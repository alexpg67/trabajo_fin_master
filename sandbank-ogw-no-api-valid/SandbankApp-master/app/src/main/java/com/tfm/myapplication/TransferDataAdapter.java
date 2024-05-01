package com.tfm.myapplication;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

// TransferDataAdapter.java
public class TransferDataAdapter extends RecyclerView.Adapter<TransferDataAdapter.TransferDataViewHolder> {
    private List<UserTransferData> transferDataList;

    public TransferDataAdapter(List<UserTransferData> transferDataList) {
        this.transferDataList = transferDataList;
    }

    @NonNull
    @Override
    public TransferDataViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.transaction_layout, parent, false);
        return new TransferDataViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull TransferDataViewHolder holder, int position) {
        UserTransferData transferData = transferDataList.get(position);
        holder.amount.setText(transferData.getAmountToTransfer());
        holder.date.setText(transferData.getDate());
    }

    @Override
    public int getItemCount() {
        return Math.min(3, transferDataList.size());
    }

    public static class TransferDataViewHolder extends RecyclerView.ViewHolder {
        TextView amount, date;

        public TransferDataViewHolder(@NonNull View itemView) {
            super(itemView);
            date = itemView.findViewById(R.id.date);
            amount = itemView.findViewById(R.id.amount);
        }
    }
}
