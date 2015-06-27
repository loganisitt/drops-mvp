package com.drops.drops;


import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.app.Fragment;
import android.preference.DialogPreference;
import android.text.InputType;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
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

        offer.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                final EditText input = new EditText(getActivity());
                input.setInputType(InputType.TYPE_NUMBER_FLAG_DECIMAL);

                new AlertDialog.Builder(getActivity())
                        .setTitle("PAYUP")
                        .setMessage("Description..")
                        .setView(input)
                        .setPositiveButton("Buy it", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {

                            }
                        })
                        .setNegativeButton("Dont", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {

                            }
                        })
                        .setIcon(android.R.drawable.sym_def_app_icon)
                        .show();

            }
        });

        message.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                // Creates a text input line
                final EditText input = new EditText(getActivity());
                input.setInputType(InputType.TYPE_CLASS_TEXT);

                // Create new Dialog, add input line
                new AlertDialog.Builder(getActivity())
                        .setTitle("TIttle")
                        .setMessage("Message things to people")
                        .setView(input)
                        .setPositiveButton("yas", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {

                            }
                        })
                        .setNegativeButton("Nah", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {

                            }
                        })
                        .setIcon(android.R.drawable.sym_def_app_icon)
                        .show();
            }
        });

        return view;
    }


}
