package com.drops.drops;

import com.twitter.sdk.android.core.models.User;

import java.util.ArrayList;

// ********************************************
// *
// *    Created by Iosif Vilcea
// *      on 6/24/15.
// *
// ********************************************
public class SellListItem {
    public String itemTitle;
    public String itemLocation;
    public String itemPrice;
    public int itemUserProfilePicture;
    public int itemPicture;

    public SellListItem(String itemTitle, String itemLocation, String itemPrice,
                        int itemUserProfilePicture, int itemPicture){
        this.itemTitle    = itemTitle;
        this.itemLocation = itemLocation;
        this.itemPrice    = itemPrice;
        this.itemUserProfilePicture = itemUserProfilePicture;
        this.itemPicture  = itemPicture;
    }

    public static ArrayList<SellListItem> getSellList(){
        ArrayList<SellListItem> sellList = new ArrayList<>();
        sellList.add(new SellListItem("Joker", "NY", "50$", R.drawable.ic_media_play, R.drawable.ic_cast_dark));
        sellList.add(new SellListItem("Joker", "NY", "50$", R.drawable.ic_media_play, R.drawable.ic_cast_dark));
        sellList.add(new SellListItem("Joker", "NY", "50$", R.drawable.ic_media_play, R.drawable.ic_cast_dark));
        sellList.add(new SellListItem("Joker", "NY", "50$", R.drawable.ic_media_play, R.drawable.ic_cast_dark));
        sellList.add(new SellListItem("Joker", "NY", "50$", R.drawable.ic_media_play, R.drawable.ic_cast_dark));
        sellList.add(new SellListItem("Joker", "NY", "50$", R.drawable.ic_media_play, R.drawable.ic_cast_dark));
        sellList.add(new SellListItem("Joker", "NY", "50$", R.drawable.ic_media_play, R.drawable.ic_cast_dark));
        sellList.add(new SellListItem("Joker", "NY", "50$", R.drawable.ic_media_play, R.drawable.ic_cast_dark));
        return sellList;
    }

}
