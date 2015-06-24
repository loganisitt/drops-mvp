package com.drops.drops;


import android.app.ListFragment;
import android.content.Context;
import android.os.Bundle;
import android.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.text.Layout;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;

import org.w3c.dom.Text;

import java.util.ArrayList;
import java.util.List;


public class sellingListFragment extends Fragment{


    public sellingListFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_selling_list, container, false);
        populateSellingList(view);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState){
        super.onActivityCreated(savedInstanceState);

    }

    private void populateSellingList(View view){
        // Construct the data source
        ArrayList<SellListItem> arrayOfItems = SellListItem.getSellList();

        // Create the adapter to convert the array to views
        ListItemAdapter adapter = new ListItemAdapter(view.getContext(), arrayOfItems);

        // Attach the adapter
        ListView listview = (ListView) view.findViewById(R.id.selling_list);
        listview.setAdapter(adapter);
    }

}
