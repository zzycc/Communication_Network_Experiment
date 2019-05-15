package com.example.esd.app0410835;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    Button setbutton,resetButton;
    TextView content;
    TextView name;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        setbutton=(Button) findViewById(R.id.set_button);
        resetButton=(Button) findViewById(R.id.reset_button);
        content=(TextView) findViewById(R.id.text);
        name=(TextView) findViewById(R.id.editText);
        setbutton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                content.setText("Welcome to Android,"+name.getText().toString());
            }
        });
        resetButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                content.setText("Hello World");
            }
        });
    }
}
