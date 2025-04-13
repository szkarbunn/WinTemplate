#include <wx/wx.h>
//#include <wx/button.h>

#include <windows.h>
#include <string>
#include <wx/wx.h>
#include <wx/event.h>
#include <iostream>
#include <fstream>
#include <fcntl.h>
#include <io.h>
#include <stdio.h>
#include <chrono>
#include <thread>


class MyApp : public wxApp {
public:
    virtual bool OnInit();
};

class MyFrame : public wxFrame {
public:
    MyFrame(const wxString& title);
};

wxIMPLEMENT_APP(MyApp);

bool MyApp::OnInit() {
    MyFrame* frame = new MyFrame("Minimal wxWidgets App");
    frame->Show(true);
    return true;
}

MyFrame::MyFrame(const wxString& title)
    : wxFrame(NULL, wxID_ANY, title, wxDefaultPosition, wxSize(400, 300)) {

    wxPanel* panel = new wxPanel(this);
    wxBoxSizer* sizer = new wxBoxSizer(wxVERTICAL);

    wxButton* btn = new wxButton(panel, wxID_ANY, "Click Me", wxDefaultPosition, wxDefaultSize);
    sizer->Add(btn, 0, wxALL | wxALIGN_CENTER, 10);

    panel->SetSizer(sizer);
}