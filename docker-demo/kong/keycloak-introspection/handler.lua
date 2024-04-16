-- keycloak-introspection/handler.lua

local http = require("resty.http")
local cjson = require("cjson")

local KeycloakIntrospectionHandler = {
  VERSION  = "1.0.0",
  PRIORITY = 10,
}

function KeycloakIntrospectionHandler:access(config)
    -- Obtener el token de acceso de los encabezados de la solicitud
    local auth_header = ngx.var.http_authorization

    if not auth_header then
        ngx.log(ngx.ERR, "Encabezado de autorización no encontrado")
        return ngx.exit(ngx.HTTP_UNAUTHORIZED)
    end

    -- Extraer el token del encabezado de autorización
    -- Asumiendo que el encabezado es de la forma "Bearer TOKEN"
    local _, _, access_token = string.find(auth_header, "Bearer%s+(.+)")

    if not access_token then
        ngx.log(ngx.ERR, "Token de acceso no encontrado en el encabezado de autorización")
        return ngx.exit(ngx.HTTP_UNAUTHORIZED)
    end

    -- Introspectar el token de acceso con Keycloak
    local introspection_url = config.keycloak_introspection_url
    local httpc = http.new()

    local headers = {
        ["Content-Type"] = "application/x-www-form-urlencoded",
        ["Authorization"] = "Basic " .. ngx.encode_base64(config.client_id .. ":" .. config.client_secret),
    }

    local body = "token=" .. access_token
    local request_options = {
        method = "POST",
        body = body,
        headers = headers,
    }

    local res, err = httpc:request_uri(introspection_url, request_options)

    if not res then
        ngx.log(ngx.ERR, "Falló la introspección del token: ", err)
        return ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
    end

    if res.status ~= 200 then
        ngx.log(ngx.ERR, "La introspección del token falló con estado: ", res.status)
        return ngx.exit(ngx.HTTP_UNAUTHORIZED)
    end

    -- Analizar la respuesta de la introspección
    local introspection_result = cjson.decode(res.body)

    if not introspection_result.active then
        ngx.log(ngx.ERR, "El token de acceso no está activo")
        return ngx.exit(ngx.HTTP_UNAUTHORIZED)
    end

    -- Agregar resultado de la introspección a los encabezados de la solicitud
    ngx.req.set_header("X-User-Id", introspection_result.sub)
    ngx.req.set_header("X-Username", introspection_result.username)

    -- Cerrar la conexión HTTP
    httpc:close()
end


return KeycloakIntrospectionHandler