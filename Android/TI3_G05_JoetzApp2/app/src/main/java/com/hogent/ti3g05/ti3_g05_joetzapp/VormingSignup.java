package com.hogent.ti3g05.ti3_g05_joetzapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.Toast;

import com.hogent.ti3g05.ti3_g05_joetzapp.Services.ConnectionDetector;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.Arrays;
import java.util.List;


public class VormingSignup extends Activity {
    private Spinner spnDataInschrijven;

    private ConnectionDetector cd;
    private Boolean isInternetPresent = false;

    private String vormingID;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_vorming_signup);
        cd = new ConnectionDetector(getApplicationContext());


        Intent i = getIntent();
        String[] voorlopigePeriodes = i.getStringArrayExtra("periodes");
        List<String> periodes = Arrays.asList(voorlopigePeriodes);
        vormingID = i.getStringExtra("objectId");

        ArrayAdapter<String> dataAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, periodes);
        dataAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spnDataInschrijven = (Spinner) findViewById(R.id.spnDataVorming);
        spnDataInschrijven.setAdapter(dataAdapter);

        Button btnInschrijven = (Button) findViewById(R.id.btnInschrijven);
        btnInschrijven.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // get Internet status
                isInternetPresent = cd.isConnectingToInternet();
                // check for Internet status

                if (isInternetPresent) {
                    // Internet Connection is Present
                    // make HTTP requests
                    if(opslaanGegevens())
                    {
                        Toast.makeText(getApplicationContext(), getString(R.string.dialog_ingeschreven_melding), Toast.LENGTH_SHORT).show();
                        Intent in = new Intent(getApplicationContext(),Vormingen_Overzicht.class);
                        startActivity(in);
                    }
                }
                else{
                    // Internet connection is not present
                    // Ask user to connect to Internet
                    Toast.makeText(getApplicationContext(), getString(R.string.error_no_internet), Toast.LENGTH_SHORT).show();
                }

            }
        });

    }

    //alle gegevens worden opgeslagen en doorgestuurd naar de DB.
    // Indien alles is gelukt -> return true en ga door naar volgend scherm Indien er een fout is gebeurd -> return false;
    public boolean opslaanGegevens(){
        //3 gegevens nodig, objectID van Monitor, objectID van Vorming & geselecteerde data.
        String emailToLookFor = ParseUser.getCurrentUser().getEmail();
        ParseQuery<ParseObject> query = ParseQuery.getQuery("Monitor");
        query.whereEqualTo("email", emailToLookFor);

        String monitorId = null;
        try{
            ParseQuery<ParseObject> querry = new ParseQuery<ParseObject>("Monitor");
            querry.orderByAscending("naam");
            List<ParseObject> lijstMonitoren = querry.find();
            for (ParseObject monitor : lijstMonitoren) {
                if(monitor.get("email").equals(ParseUser.getCurrentUser().getEmail()))
                {
                    monitorId = monitor.getObjectId();
                }

            }
            ParseQuery<ParseObject> queryV = new ParseQuery<ParseObject>(
                    "InschrijvingVorming");

            queryV.orderByAscending("monitor");
            List<ParseObject> lijstInschrijvingVormingen = queryV.find();
            for (ParseObject vormingIns : lijstInschrijvingVormingen) {
                if(vormingIns.get("monitor").equals(monitorId) && vormingIns.get("vorming").equals(vormingID) && vormingIns.get("periode").equals(String.valueOf(spnDataInschrijven.getSelectedItem())))
                {
                    Toast.makeText(VormingSignup.this, "U heeft zich al ingeschreven voor deze vorming." , Toast.LENGTH_LONG).show();
                    return false;
                }

            }
        }
        catch(Exception e){
            Toast.makeText(this,"fout bij ophalen monitoren",Toast.LENGTH_LONG).show();
        }
        try{
            List<ParseObject> lijstObjecten = query.find();
            if (lijstObjecten.size() != 1){
                Toast.makeText(getApplicationContext(), "Er is iets fout gelopen. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT).show();
                return false;
            }
            else{//er is slechts 1 gebruiker in de Monitor tabel, zoals het hoort.
                String monitorID = lijstObjecten.get(0).getObjectId();
                ParseObject nieuweVorming = new ParseObject("InschrijvingVorming");

                nieuweVorming.put("vorming", vormingID);
                nieuweVorming.put("monitor", monitorID);
                nieuweVorming.put("periode", String.valueOf(spnDataInschrijven.getSelectedItem()) );
                nieuweVorming.saveInBackground();
                return true;

            }
        }
        catch(ParseException e){
            Toast.makeText(getApplicationContext(), "Er is iets fout gelopen. Onze excuses voor het ongemak.", Toast.LENGTH_SHORT).show();
            return false;
        }

    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.back_2, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.backMenu2) {
            Intent intent1 = new Intent(this, navBarMainScreen.class);
            intent1.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent1);

            overridePendingTransition(R.anim.left_in, R.anim.right_out);
        }

        return super.onOptionsItemSelected(item);
    }


}
