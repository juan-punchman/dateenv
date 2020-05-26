#include <cstdlib>
#include <date/date.h>
#include <date/tz.h>
#include <iostream>


namespace volar {

// - http://stackoverflow.com/questions/40306012/c-using-environment-variables-for-paths
// - https://msdn.microsoft.com/en-us/library/ms682009.aspx
#ifdef _WIN32

  std::string getEnvironmentVariable(const std::string &key) {
    // it seems like getenv is in the c++11 standard, let's give it a spin on windows...
    char *val = getenv(key.c_str());
    // return val == NULL ? key + std::string( " not defined" ) : std::string( val );
    return val == NULL ? std::string("") : std::string(val);
  }

#else

// http://stackoverflow.com/questions/631664/accessing-environment-variables-in-c?noredirect=1&lq=1
  std::string getEnvironmentVariable(const std::string &key) {
      char *val = getenv(key.c_str());
      // return val == NULL ? key + std::string( " not defined" ) : std::string( val );
      return val == NULL ? std::string("") : std::string(val);
  }

#endif

}


int main() {
    using std::cout;
    using std::endl;
    using namespace date;
    using namespace std::chrono;

    cout << "starting test.." << endl;

    {
        auto tpUTC = system_clock::now();
        auto const zt = make_zoned("America/New_York", tpUTC); // locate the timezone every time
        auto const tp = zt.get_local_time();
        auto const dp = floor<days>(tp);
        auto const ymd = year_month_day(dp);
    }

    cout << "ending test" << endl;
}
