def problem_3(n):
    def is_prime(k):
        if k < 2:
            return False
        for i in range(2, int(k**0.5) + 1):
            if k % i == 0:
                return False
        return True

    def largest_prime_factor(n):
        factor = 2
        last_factor = 1
        while n > 1:
            if n % factor == 0:
                last_factor = factor
                n //= factor
                while n % factor == 0:
                    n //= factor
            factor += 1
        return last_factor

    return largest_prime_factor(n)

if __name__ == "__main__":
    print(problem_3(600851475143))