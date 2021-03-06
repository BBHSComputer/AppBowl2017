package bbhs.appbowl2017;

import android.content.Context;
import android.content.Intent;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.RadioButton;
import android.widget.TextView;

import java.util.Locale;

import bbhs.appbowl2017.music.MusicActivity;
import bbhs.appbowl2017.stack.StackActivity;
import bbhs.appbowl2017.summation.SummationGame;
import bbhs.appbowl2017.tile.ChooseImagesDialog;
import bbhs.appbowl2017.tile.TileGameActivity;

import android.widget.RelativeLayout;

import static bbhs.appbowl2017.tile.ChooseImagesDialog.cards;


public class MainActivity extends AppCompatActivity {

    private boolean expanded[];
    private ImageButton[] dropdownButtons;
    private TextView[] descriptions;
    private View[] settings;
    private boolean tellRules;

    public static int stackLevel = 1, tileNumPairs = 16;

    private Button customImages;
    private  Button  defaultImages;

    public static Context appCont;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        appCont = getApplicationContext();

        expanded = new boolean[4];
        dropdownButtons = new ImageButton[]{(ImageButton) findViewById(R.id.stackDropdown), (ImageButton) findViewById(R.id.tileDropdown), (ImageButton) findViewById(R.id.sumDropdown), (ImageButton) findViewById(R.id.musicDropdown)};
        descriptions = new TextView[]{(TextView) findViewById(R.id.stackDesc), (TextView) findViewById(R.id.tileDesc), (TextView) findViewById(R.id.sumDesc), (TextView) findViewById(R.id.musicDesc)};
        settings = new View[]{findViewById(R.id.stackSettings), findViewById(R.id.tileSettings), findViewById(R.id.sumSettings), findViewById(R.id.musicSettings)};

        Button stackPlay = (Button) findViewById(R.id.stackPlay);
        Button tilePlay = (Button) findViewById(R.id.tilePlay);
        Button sumPlay = (Button) findViewById(R.id.sumPlay);
        Button musicPlay = (Button) findViewById(R.id.musicPlay);

        Button stackAdd = (Button) findViewById(R.id.stackAdd);
        Button stackSubtract = (Button) findViewById(R.id.stackSubtract);
        final TextView stackValue = (TextView) findViewById(R.id.stackValue);
        final RadioButton stackGuess = (RadioButton) findViewById(R.id.stackGuess);
        final RadioButton stackTell = (RadioButton) findViewById(R.id.stackTell);

        Button tileAdd = (Button) findViewById(R.id.tileAdd);
        Button tileSubtract = (Button) findViewById(R.id.tileSubtract);
        Button tileConfigure = (Button) findViewById(R.id.tileChangeImages);
        final TextView tileValue = (TextView) findViewById(R.id.tileValue);

        final RelativeLayout layout = (RelativeLayout) findViewById(R.id.main_activity);

        tellRules = true;

        for (int i = 0; i < dropdownButtons.length; i++) {
            final int n = i;

            dropdownButtons[i].setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if (expanded[n]) {
                        dropdownButtons[n].setRotation(0);
                        descriptions[n].setMinLines(2);
                        descriptions[n].setMaxLines(2);
                        settings[n].setVisibility(View.GONE);
                        expanded[n] = false;
                    } else {
                        dropdownButtons[n].setRotation(-180);
                        descriptions[n].setMinLines(3);
                        descriptions[n].setMaxLines(Integer.MAX_VALUE);
                        settings[n].setVisibility(View.VISIBLE);
                        expanded[n] = true;
                    }
                }
            });
        }

        stackPlay.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent stackIntent = new Intent(getApplicationContext(), StackActivity.class);
                stackIntent.putExtra("tellRules", tellRules);
                stackIntent.putExtra("ruleNum", Integer.parseInt(stackValue.getText().toString()));
                System.out.println("BBDEBUG: " + tellRules);
                startActivity(stackIntent);
            }
        });
        tilePlay.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(cards != null){
                    startActivity(new Intent(getApplicationContext(), TileGameActivity.class));
                }
                else{
                    Snackbar snackbar = Snackbar.make(layout, getString(R.string.tileException), Snackbar.LENGTH_LONG);
                    snackbar.show();
                }
            }
        });
        sumPlay.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getApplicationContext(), SummationGame.class));

            }
        });
        musicPlay.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getApplicationContext(), MusicActivity.class));

            }
        });
        stackGuess.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (stackTell.isChecked())
                    stackTell.setChecked(false);
                tellRules = false;
            }
        });
        stackTell.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (stackGuess.isChecked())
                    stackGuess.setChecked(false);
                tellRules = true;
            }
        });
        stackAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (stackLevel < 43)
                    stackValue.setText(String.format(Locale.getDefault(), "%d", ++stackLevel));
            }
        });
        stackSubtract.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (stackLevel > 1)
                    stackValue.setText(String.format(Locale.getDefault(), "%d", --stackLevel));
            }
        });
        tileAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (tileNumPairs < 16)
                    tileValue.setText(String.format(Locale.getDefault(), "%d", ++tileNumPairs));
            }
        });
        tileSubtract.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (tileNumPairs > 1)
                    tileValue.setText(String.format(Locale.getDefault(), "%d", --tileNumPairs));
            }
        });

        tileConfigure.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ChooseImagesDialog dialog = new ChooseImagesDialog();
                Bundle args = new Bundle();
                args.putInt("tileNumPairs", tileNumPairs);
                dialog.setArguments(args);
                dialog.show(getSupportFragmentManager(), "ChooseImages");

            }
        });

    }


    public void setPopUpButtons(){
        Log.d("uio", "ipo");
        Log.d("uio", new Boolean((View) (findViewById(R.id.tileImageSelectPopup)) == null).toString());
        //I've been moved to ChooseImagesDialog thanks
    }


}
