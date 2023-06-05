#include <cstddef>

const int V_NUM_ELEMS = 4;
using v_type = float[V_NUM_ELEMS];

float get_nth(v_type v, size_t i) { return v[i]; }
