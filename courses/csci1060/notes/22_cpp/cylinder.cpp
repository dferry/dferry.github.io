#include <cmath>
#include <iostream>
using namespace std;

double cylinder(double height, double radius=1.0) {
  double base = M_PI * radius * radius;
  double area = 2 * M_PI * radius * height + 2 * base;
  return area;
}


int main() {
  double h, r;
  cout << "Height? ";
  cin >> h;
  cout << "Radius? ";
  cin >> r;
  double area = cylinder(h, r);
  cout << "Surface area is " << area << endl;
}
