#ifndef __template__library_name_HPP
#define __template__library_name_HPP


[[nodiscard]] int factorial(int) noexcept;

[[nodiscard]] constexpr int factorial_constexpr(int input) noexcept
{
  if (input == 0) { return 1; }

  return input * factorial_constexpr(input - 1);
}

#endif
