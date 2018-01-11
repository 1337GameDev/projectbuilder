#include <json.hpp>
#include <fstream>
#include <iostream>
#include <test.h>
#include <boost/filesystem.hpp>
#include <boost/dll/runtime_symbol_info.hpp>

using namespace nlohmann;
using namespace std;

int main(){
	boost::filesystem::path prgm_path = boost::dll::program_location();
	std::cout << "This program path: " << prgm_path << std::endl;
	boost::filesystem::path prgm_loc = prgm_path.parent_path();
	std::cout << "This program parent location: " << prgm_loc << std::endl;
	boost::filesystem::path jsonPath = prgm_loc/="/test.json";
	std::cout << "This json location: " << jsonPath << std::endl;

	ifstream ifile(jsonPath.string() );
	if(!ifile) {
		cout << "Error opening file" << endl;
  } else {
		cout << "File opened" << endl;
	}

	json j = json::parse(ifile);
	j["gender"] = "male";

	std::cout << "---- JSON ---- \n" << j.dump(4) << std::endl;

	if(j["phone"] == NULL) {
		std::cout << "phone key not found in json" << std::endl;
	}

	std::stringstream ss;
	for (json::iterator it = j.begin(); it != j.end(); ++it) {
   	ss << it.key();
		string key = ss.str();
		ss.str(std::string());

		ss << it.value();
		string value = ss.str();
		ss.str(std::string());

	  std::cout << "key: " << key << " - value: " << value << "\n";
	}

	json j2 = j;
	j2["gender"] = "female";
	j["phone"] = "555-5555555";
	cout << "\n\n\njson original:" << endl;
  cout << j.dump(4) << endl;
	cout << "\n\n\njson copy:" << endl;
  cout << j2.dump(4) << endl;

  return 0;
}

std::string getpath() {
char buf[PATH_MAX + 1];
if (readlink("/proc/self/exe", buf, sizeof(buf) - 1) == -1)
	return "readlink() failed";
	std::string str(buf);
	return str.substr(0, str.rfind('/'));
}
