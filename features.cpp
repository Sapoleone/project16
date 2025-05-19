//Features.cpp
#import <iostream>
#import <cstdlib>
#include <string>
#import <ctime>
using namespace std;


string folderName = "";
string execName = "EXEC";
string path = "C:/Program Files/";

int attrList() {
	int usr;
	cout << "+------- MENU' -------+" << endl;
	cout << "| 1. Remote Access    |" << endl;
	cout << "| 2. Features (list)  |" << endl;
	cout << "| 3. Get Token        |" << endl;
	cout << "+---------------------+" << endl;
	cout << "Scegli un opzione: ";
	cin >> usr;
	return usr;
}

int main(){
	int usr;
	string tmp = "cd /D " + '"' + path + '"'+"";
	system(tmp.c_str());
	
	system( "echo %cd%" );
	
	usr = attrList();
	
	switch (usr) {
		case 1:
			int sel;
			string ip;
			cout << "Control (0) or View(1)? ";
			cin >> sel;
			cout << "Select host(IP): ";
			cin >> ip;
			system( (" echo %cd% && "+execName+" remoteaccess "+((!sel)?"control":"view")+" "+ip).c_str() );
			break;
			
	/*	case 2:
			cout << "2.";
			break;
		case 3:
			cout << "3.";
			break;*/
	}
	//rem acc <Ctrl/Vw> <IP>
	
	//system(execName+
	//feature <sr/st> <IP> <FeatureName> <JSON-ARGS>
	
	//get TokenFromWebUI <IP>
}