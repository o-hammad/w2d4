# More Problems!

# The following problems do not have specs and cover many different topics. You'll
# want to follow the prompt for each problem and make sure your implementation
# satisfies the behavior in the given examples. Create a __.rb__ file to work in
# and test your code manually by running `ruby <your-file-name>.rb`!


## General Problems

### no_dupes?

# Write a method `no_dupes?(arr)` that accepts an array as an arg and returns a
# new array containing the elements that were not repeated in the array.

def no_dupes?(arr)
    hash_count = Hash.new(0)

    arr.each { |ele| hash_count[ele] += 1 }

    hash_count.select { |k, v| v < 2 }.keys
end

# Examples
p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
p no_dupes?([true, true, true])            # => []
puts "-----------------------------"


### no_consecutive_repeats?

# Write a method `no_consecutive_repeats?(arr)` that accepts an array as an arg.
# The method should return `true` if an element never appears consecutively in the
# array; it should return `false` otherwise.

def no_consecutive_repeats?(arr)
    (0...arr.length - 1).each do |i|
        return false if arr[i] == arr[i + 1]
    end

    true
end

# Examples
p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
p no_consecutive_repeats?(['x'])                              # => true
puts "-----------------------------"

### char_indices

# Write a method `char_indices(str)` that takes in a string as an arg. The method
# should return a hash containing characters as keys. The value associated with
# each key should be an array containing the indices where that character is
# found.

def char_indices(str)
    hash = Hash.new { |hash, key| hash[key] = Array.new }

    str.each_char.with_index do |char, idx|
        hash[char] << idx
    end

    hash
end


# Examples
p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}
puts "-----------------------------"

### longest_streak

# Write a method `longest_streak(str)` that accepts a string as an arg. The method
# should return the longest streak of consecutive characters in the string. If
# there are any ties, return the streak that occurs later in the string.

def longest_streak(str)
    streak = 1
    current_streak = ""

    (0...str.length).each do |i|
        if str[i] == str[i + 1]
            streak += 1
        else
            streak = 1
        end

        if streak >= current_streak.length
            current_streak = str[i] * streak
        end
    end

    current_streak
end

# Examples
p longest_streak('a')           # => 'a'
p longest_streak('accccbbb')    # => 'cccc'
p longest_streak('aaaxyyyyyzz') # => 'yyyyy
p longest_streak('aaabbb')      # => 'bbb'
p longest_streak('abc')         # => 'c'
puts "-----------------------------"

### bi_prime?

# Write a method `bi_prime?(num)` that accepts a number as an arg and returns a
# boolean indicating whether or not the number is a bi-prime. A bi-prime is a
# positive integer that can be obtained by multiplying two prime numbers.

# For Example:

# + `14` is a bi-prime because `2 * 7`
# + `22` is a bi-prime because `2 * 11`
# + `25` is a bi-prime because `5 * 5`
# + `24` is not a bi-prime because no two prime numbers have a product of `24`

def bi_prime?(num)
    (2...num).any? { |divisor| num % divisor == 0 && prime?(divisor) && prime?(num / divisor) }
end

def prime?(num)
    return false if num < 2
    (2...num).none? { |divisor| num % divisor == 0 }
end


# Examples
p bi_prime?(14)   # => true
p bi_prime?(22)   # => true
p bi_prime?(25)   # => true
p bi_prime?(94)   # => true
p bi_prime?(24)   # => false
p bi_prime?(64)   # => false
puts "-----------------------------"

### vigenere_cipher

# A Caesar cipher takes a word and encrypts it by offsetting each letter in the
# word by a fixed number, called the key. Given a key of 3, for example: a -> d, p
# -> s, and y -> b.

# A Vigenere Cipher is a Caesar cipher, but instead of a single key, a sequence of
# keys is used. For example, if you encrypt "bananasinpajamas" with the key
# sequence \[1, 2, 3], then the result would be "ccqbpdtkqqcmbodt":

# ```ruby
# # Message:  b a n a n a s i n p a j a m a s
# # Keys:     1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1
# # Result:   c c q b p d t k q q c m b o d t
# ```

# Write a method `vigenere_cipher(message, keys)` that accepts a string and a
# key-sequence as args, returning the encrypted message. Assume that the message
# consists entirely of lowercase alphabetic characters.

def vigenere_cipher(word, key_sequence)
    alpha = ("a".."z").to_a
    encrypted_string = ""

    word.each_char do |char|
        current_index = alpha.index(char)
        new_index = (current_index + key_sequence.first) % 26
        key_sequence.rotate!
        encrypted_string += alpha[new_index]
    end

    encrypted_string
end

# Examples
p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
p vigenere_cipher("yawn", [5, 1])             # => "dbbo"
puts "-----------------------------"


### vowel_rotate

# Write a method `vowel_rotate(str)` that accepts a string as an arg and returns
# the string where every vowel is replaced with the vowel that appears before it
# sequentially in the original string. The first vowel of the string should be
# replaced with the last vowel.

def vowel_rotate(str)
    vowels = "aeiou"
    vowels_arr = []

    str.each_char { |char| vowels_arr << char if vowels.include?(char) }
    vowels_arr.rotate!(-1)
    str.each_char.with_index { |char, idx| str[idx] = vowels_arr.shift if vowels.include?(char) }

    str
end

# Examples
p vowel_rotate('computer')      # => "cempotur"
p vowel_rotate('oranges')       # => "erongas"
p vowel_rotate('headphones')    # => "heedphanos"
p vowel_rotate('bootcamp')      # => "baotcomp"
p vowel_rotate('awesome')       # => "ewasemo"
puts "-----------------------------"

## Proc Problems

### String#select

# Extend the `String` class by defining a `String#select` method that accepts a
# block. The method should return a new string containing characters of the
# original string that return `true` when passed into the block. If no block is
# passed, then return the empty string. Do **NOT** use the built-in `Array#select`
# in your solution.

class String
    def select(&prc)
        return "" if prc == nil
        new_str = ""

        self.each_char do |char|
            new_str += char if prc.call(char)
        end
        new_str
    end
end

# Examples
p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
p "HELLOworld".select          # => ""
puts "-----------------------------"

#### String#map!

# Extend the `String` class by defining a `String#map!` method that accepts a
# block. The method should modify the existing string by replacing every character
# with the result of calling the block, passing in the original character and it's
# index. Do **NOT** use the built-in `Array#map` or `Array#map!` in your solution.

class String
    def map!(&prc)
        self.each_char.with_index do |char, idx|
            self[idx] = prc.call(char, idx)
        end
        self
    end
end

# Examples
word_1 = "Lovelace"
word_1.map! do |ch| 
    if ch == 'e'
        '3'
    elsif ch == 'a'
        '4'
    else
        ch
    end
end
p word_1        # => "Lov3l4c3"

word_2 = "Dijkstra"
word_2.map! do |ch, i|
    if i.even?
        ch.upcase
    else
        ch.downcase
    end
end
p word_2        # => "DiJkStRa"
puts "-----------------------------"

## Recursion Problems

### multiply

# Write a method `multiply(a, b)` that takes in two numbers and returns their
# product.

# + You must solve this recursively (no loops!)
# + You must **NOT** use the multiplication (*) operator

def multiply(a, b)
    return a if b == 1 || b == -1
    
    if b < 0
        return a + multiply(a, b + 1)
    else
        return a + multiply(a, b - 1)
    end
end

# Examples
p multiply(3, 5)        # => 15
p multiply(5, 3)        # => 15
p multiply(2, 4)        # => 8
p multiply(0, 10)       # => 0
p multiply(-3, -6)      # => 18
p multiply(3, -6)       # => -18
p multiply(-3, 6)       # => -18
puts "-----------------------------"

#### lucas_sequence

# The Lucas Sequence is a sequence of numbers. The first number of the sequence is
# 2. The second number of the Lucas Sequence is 1. To generate the next number of
# the sequence, we add up the previous two numbers. For example, the first six
# numbers of the sequence are: 2, 1, 3, 4, 7, 11, ...

# Write a method `lucasSequence` that accepts a number representing a length as an
# arg. The method should return an array containing the Lucas Sequence up to the
# given length. Solve this recursively.

def lucas_sequence(length)
    return [] if length == 0
    return [2] if length == 1
    return [2, 1] if length == 2
    
    lucas_sequence(length - 1).push(lucas_sequence(length - 1)[-2] + lucas_sequence(length - 1)[-1])
end

# Examples
p lucas_sequence(0)   # => []
p lucas_sequence(1)   # => [2]    
p lucas_sequence(2)   # => [2, 1]
p lucas_sequence(3)   # => [2, 1, 3]
p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]
puts "-----------------------------"

#### prime_factorization

# [The Fundamental Theorem of Arithmetic][theorem] states that every positive
# integer is either a prime or can be represented as a product of prime numbers.

# Write a method `prime_factorization(num)` that accepts a number and returns an
# array representing the prime factorization of the given number. This means that
# the array should contain only prime numbers that multiply together to the given
# num. The array returned should contain numbers in ascending order. Do this
# recursively.

def prime_factorization(num)
    # return [] if num == 0
    # greatest_prime_divisor = 1

    # num.downto(1).each do |divisor| 
    #     if (num % divisor == 0) && (prime?(divisor))
    #         greatest_prime_divisor = divisor
    #         break
    #     end
    #     num = 0 if divisor < 2
    # end

    # if greatest_prime_divisor == 1
    #     prime_factorization(num / greatest_prime_divisor)
    # else
    #     prime_factorization(num / greatest_prime_divisor) + [greatest_prime_divisor]
    # end

    return [] if num < 2


    greatest_prime_divisor = num

    num.downto(1).each do |divisor|
        if prime?(divisor) && num % divisor == 0
            greatest_prime_divisor = divisor
            break
        end
        num = 0 if divisor < 2
    end

    prime_factorization(num / greatest_prime_divisor) + [greatest_prime_divisor]
end

# Examples
p prime_factorization(12)     # => [2, 2, 3]
p prime_factorization(24)     # => [2, 2, 2, 3]
p prime_factorization(25)     # => [5, 5]
p prime_factorization(60)     # => [2, 2, 3, 5]
p prime_factorization(7)      # => [7]
p prime_factorization(11)     # => [11]
p prime_factorization(2017)   # => [2017]
puts "-----------------------------"

#[theorem]: https://en.wikipedia.org/wiki/Fundamental_theorem_of_arithmetic

