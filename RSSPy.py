import random

# Simulation parameters
total_data_size = 1000   # Total number of data points in the dataset B
subset_size = 100        # Size of the subset S
population_size = 50     # Number of individuals in the GP population
max_generations = 10     # Total number of generations

# Step 1: Generate the dataset B
dataset = [f"data_point_{i}" for i in range(total_data_size)]

# Step 2: Initialize population
def initialize_population(size):
    """Randomly generate an initial population of GP programs."""
    return [f"program_{i}" for i in range(size)]

# Step 3: Fitness evaluation
def evaluate_population(population, subset):
    """Simulate fitness evaluation on a subset."""
    return {program: random.uniform(0, 1) for program in population}

# Step 4: Evolve population
def evolve_population(population, fitness_scores):
    """Simulate evolution by selecting top-performing programs."""
    # Sort by fitness (higher is better)
    sorted_population = sorted(population, key=lambda p: fitness_scores[p], reverse=True)
    # Select the top 50% to reproduce
    selected_parents = sorted_population[:len(population) // 2]
    # Create next generation by duplicating parents
    next_generation = selected_parents + selected_parents
    # Simulate mutation by shuffling a bit
    random.shuffle(next_generation)
    return next_generation

# Step 5: RSS simulation
def rss_simulation():
    # Step 1: Initialize the population
    population = initialize_population(population_size)
    print(f"Initial population: {population}\n")

    # Step 2: Run generations
    for generation in range(max_generations):
        print(f"--- Generation {generation} ---")
        
        # Generate a random subset S(g) from dataset B
        subset = random.sample(dataset, subset_size)
        print(f"Random subset for generation {generation}: {subset[:5]}... (showing 5 of {subset_size})")
        
        # Evaluate the population on the current subset
        fitness_scores = evaluate_population(population, subset)
        print(f"Fitness scores: {list(fitness_scores.items())[:5]}... (showing 5 of {population_size})")
        
        # Evolve the population
        population = evolve_population(population, fitness_scores)
        print(f"Evolved population: {population}... (showing 5 of {population_size})\n")

    print(f"Final population after {max_generations} generations: {population}")

# Run the simulation
rss_simulation()
