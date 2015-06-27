package com.drops.drops;


import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;


/**
 * A simple {@link Fragment} subclass.
 */
public class ListingInfo extends Fragment {


    TextView title;
    TextView description;
    TextView price;
    TextView category;
    Button offer;
    Button message;

    public ListingInfo() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_listing_info, container, false);

        title       = (TextView) view.findViewById(R.id.titleItemLI);
        description = (TextView) view.findViewById(R.id.descItemLI);
        price       = (TextView) view.findViewById(R.id.priceItemLI);
        category    = (TextView) view.findViewById(R.id.catItemLI);

        offer       = (Button) view.findViewById(R.id.offerButtonLI);
        message     = (Button) view.findViewById(R.id.sellerButtonLI);

        title.setText("Item Title #");
        description.setText("Item desc here. things. more things. other things.");
        price.setText("lots of $$$");
        category.setText("IDK");

        return view;
    }


}
