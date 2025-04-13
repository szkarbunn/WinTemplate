#pragma once
#include <string>

enum class LogLevel {
    LG_INFO,
    LG_WARNING,
    LG_ERROR
};

class Logger {
public:
    static void Log(LogLevel level, const std::string& msg);
    static void Info(const std::string& msg);
    static void Warn(const std::string& msg);
    static void Error(const std::string& msg);
};
