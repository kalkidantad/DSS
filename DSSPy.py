import random

# Simulation parameters
total_data_size = 100  # Total number of data points in the dataset B
subset_size = 20       # Desired size of the subset S(g)
population_size = 50   # Number of individuals in the GP population
max_generations = 10   # Total number of generations
difficulty_exponent = 2  # Exponent d for difficulty impact
age_exponent = 1        # Exponent a for age impact

# Step 1: Initialize dataset and difficulty/age for each data point
data = [f"data_point_{i}" for i in range(total_data_size)]
difficulty = {i: 0 for i in range(total_data_size)}  # Difficulty D_i
age = {i: 0 for i in range(total_data_size)}         # Age A_i

def initialize_population(size):
    """Randomly generate an initial population of GP programs."""
    return [f"program_{i}" for i in range(size)]

def evaluate_population(population, subset):
    """Simulate fitness evaluation on a subset."""
    return {program: random.uniform(0, 1) for program in population}

def evolve_population(population, fitness_scores):
    """Simulate evolution by selecting top-performing programs."""
    # Sort by fitness (higher is better)
    sorted_population = sorted(population, key=lambda p: fitness_scores[p], reverse=True)
    # Select the top 50% to reproduce
    selected_parents = sorted_population[:len(population) // 2]
    # Create next generation by duplicating parents
    next_generation = selected_parents + selected_parents
    random.shuffle(next_generation)
    return next_generation

def compute_probability(index, generation):
    """Compute the probability P_i(g) based on difficulty and age."""
    d = difficulty[index] ** difficulty_exponent
    a = age[index] ** age_exponent
    return d + a

def normalize_probabilities(probabilities):
    """Normalize probabilities to sum to 1."""
    total = sum(probabilities)
    return [p / total if total > 0 else 0 for p in probabilities]

def dss_simulation():
    """Run the DSS simulation."""
    # Initialize population
    population = initialize_population(population_size)

    for generation in range(max_generations):
        print(f"--- Generation {generation} ---")

        # Step 4: Initialize an empty subset S(g)
        subset = []

        # Step 5-11: Calculate probabilities and select subset
        probabilities = [compute_probability(i, generation) for i in range(total_data_size)]
        normalized_probs = normalize_probabilities(probabilities)

        # Select data points based on probabilities
        for i in range(total_data_size):
            if random.random() < normalized_probs[i]:
                subset.append(data[i])

        # Limit the subset size to subset_size
        subset = subset[:subset_size]
        print(f"Selected subset: {subset[:5]}... (total {len(subset)} items)")

        # Evaluate population using the selected subset
        fitness_scores = evaluate_population(population, subset)
        print(f"Fitness scores: {list(fitness_scores.items())[:5]}... (showing 5)")

        # Update difficulty and age
        for i in range(total_data_size):
            if data[i] in subset:
                age[i] = 0  # Reset age if selected
                # Simulate difficulty update (harder if often misclassified)
                difficulty[i] += 1 if random.random() > 0.7 else 0
            else:
                age[i] += 1  # Increment age if not selected

        # Evolve the population
        population = evolve_population(population, fitness_scores)

    print("Simulation complete.")

# Run the simulation
dss_simulation()
