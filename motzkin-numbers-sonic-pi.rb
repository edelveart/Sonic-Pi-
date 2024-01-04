numb = 5

define :motzkin_number do |n|
  return 1 if n <= 1
  return (
    (( 2 * n + 1) * motzkin_number(n - 1) +
     (3 * n - 3) * motzkin_number(n - 2)) / (n + 2)
  )
end

puts motzkin_number(numb)

define :shadow_motzkin do |n|
  return 1 if n <= 1
  return (((2 * n + 1) * shadow_motzkin(n - 1) -
           5 * (n - 1) * shadow_motzkin(n - 2)) /
          (n + 2))
end

puts shadow_motzkin(numb)

define :shadow_motzkin_inverse do |n|
  inversion = ((-1) ** n)
  return inversion * 1 if n <= 1
  return (inversion *
          ((2 * n + 1) * shadow_motzkin(n - 1) -
           5 * (n - 1) * shadow_motzkin(n - 2)) /
          (n + 2))
end

puts shadow_motzkin_inverse(numb)
