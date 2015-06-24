package com.drops.drops;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;

// ********************************************
// *
// *    Created by Iosif Vilcea
// *      on 6/24/15.
// *
// ********************************************
public class ListItemAdapter extends ArrayAdapter<SellListItem> {
    public ListItemAdapter(Context context, ArrayList<SellListItem> listItem){
        super(context, 0, listItem);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent){

        //Get data item for this position
        SellListItem sellList = getItem(position);

        //Check if an existing view is being reused, otherwise inflate the view.
        if(convertView == null){
            convertView = LayoutInflater.from(getContext()).inflate(R.layout.list_item, parent, false);
        }

        TextView tvItemName = (TextView) convertView.findViewById(R.id.itemNameTV);
        TextView tvItemLoc  = (TextView) convertView.findViewById(R.id.itemLocationTV);
        TextView tvItemPrice= (TextView) convertView.findViewById(R.id.itemPriceTV);
        ImageView tvItemPic  = (ImageView) convertView.findViewById(R.id.itemPictureIV);
        ImageView tvItemUserPic=(ImageView)convertView.findViewById(R.id.itemUserProfileTV);

        tvItemName.setText(sellList.itemTitle);
        tvItemLoc.setText(sellList.itemLocation);
        tvItemPrice.setText(sellList.itemPrice);
        tvItemPic.setImageResource(sellList.itemPicture);
        tvItemUserPic.setImageResource(sellList.itemUserProfilePicture);

        return convertView;
    }

}
