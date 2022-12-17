#include <fstream>
#include <iostream>
#include <string>
#include <vector>

struct AOCInput {

  AOCInput(std::string filepath) : filepath(filepath) {
    std::ifstream in_file(filepath);
  }

  std::string filepath;
  std::vector<std::string> input;
  size_t size;
};

class AOCProblem {
 public:
  AOCInput* m_input;
  std::string filepath;

  size_t getSize() { return m_input->size; }
};

class AOCDay {
 public:
  AOCDay(int day, std::string name) : m_day(day), m_name(name) {}

  std::string getName() { return m_name; }
  int getDay() { return m_day; }

  bool solve();

 private:
  std::string m_name;
  int m_day;

  AOCProblem first, second;
};