#include "Logger.h"

#ifndef NDEBUG

#include <iostream>
#include <ctime>

static std::string currentTime() {
    std::time_t now = std::time(nullptr);
    char buf[20];
    std::strftime(buf, sizeof(buf), "%H:%M:%S", std::localtime(&now));
    return buf;
}

void Logger::Log(LogLevel level, const std::string& msg) {
    std::string levelStr;
    switch (level) {
        case LogLevel::LG_INFO:    levelStr = "[INFO]   "; break;
        case LogLevel::LG_WARNING: levelStr = "[WARNING]"; break;
        case LogLevel::LG_ERROR:   levelStr = "[ERROR]  "; break;
    }
    std::cout << currentTime() << " " << levelStr << " " << msg << std::endl;
}

void Logger::Info(const std::string& msg)   { Log(LogLevel::LG_INFO, msg); }
void Logger::Warn(const std::string& msg)   { Log(LogLevel::LG_WARNING, msg); }
void Logger::Error(const std::string& msg)  { Log(LogLevel::LG_ERROR, msg); }

#else

// Release build – puste implementacje
void Logger::Info(const std::string&)  {}
void Logger::Warn(const std::string&)  {}
void Logger::Error(const std::string&) {}

#endif
