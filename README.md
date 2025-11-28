# Prolog Programming Repository 🧠

Welcome to an extensive collection of Prolog programs implementing various Artificial Intelligence algorithms, search techniques, and logical programming concepts!

## 🎯 About This Repository

This repository contains a comprehensive set of Prolog implementations covering fundamental and advanced AI algorithms. Each program is well-documented and includes example use cases to help you understand the concepts.

## 👨‍💻 Created By
**Shivaay Developer (Shivaay20005)**

AI Assistant: Shivaay Devil  
Contact: +91 8081053743

## 📚 Program Categories

### 🔍 Search Algorithms
- **A* Search** - Optimal pathfinding algorithm
- **Best First Search** - Heuristic-guided search
- **Hill Climbing** - Local optimization technique
- **Min-Max** - Game theory decision making

### 🧩 Classic Problems
- **Tower of Hanoi** - Recursive puzzle solution
- **Water Jug Problem** - State-space search
- **Sudoku Solver** - Constraint satisfaction

### 📖 Knowledge Representation
- **Enhanced Family Tree** - Complex relationship modeling
- **Frames System** - Object-oriented knowledge representation
- **Parse Trees** - Natural language processing
- **CFG Recognizer** - Context-free grammar validation

### 📊 List Operations
- List Concatenation
- List Reversal
- Element Membership
- Insert/Delete at Position

### ➕ Mathematical Functions
- Factorial & Fibonacci
- Power Calculation
- Maximum/Minimum Finding
- Arithmetic Operations

## 🚀 Getting Started

### Prerequisites
- SWI-Prolog or any Prolog interpreter

### Running the Programs
1. Clone this repository:
   ```bash
   git clone https://github.com/Shivaay20005/Prolog-Programmes.git
   ```
2. Navigate to the directory:
   ```bash
   cd Prolog-Programmes
   ```
3. Load any program in SWI-Prolog:
   ```bash
   swipl program_name.pl
   ```
4. Execute queries as shown in each file's comments

### Example Usage
```prolog
?- tower_of_hanoi(3).
Move disk from A to C
Move disk from A to B
Move disk from C to B
...

?- solve_water_jug(Solution).
Solution = [state(0, 0), state(0, 3), state(3, 0), ...]
```

## 📁 File Structure
```
Prolog-Programmes/
├── Search Algorithms/
│   ├── a_star_search.pl
│   ├── best_first_search.pl
│   ├── hill_climbing.pl
│   └── min_max.pl
├── Classic Problems/
│   ├── tower_of_hanoi.pl
│   ├── water_jug.pl
│   └── sudoku.pl
├── Knowledge Representation/
│   ├── enhanced_family_tree.pl
│   ├── frames.pl
│   ├── parse_tree.pl
│   └── cfg_anbn.pl
├── List Operations/
│   ├── list_concatenation.pl
│   ├── listreverse.pl
│   ├── member_check.pl
│   ├── insert_at_position.pl
│   └── delete_from_position.pl
└── Mathematical Functions/
    ├── factorial.pl
    ├── fibonacci.pl
    ├── power_calculation.pl
    ├── maximum_two_num.pl
    ├── maximum_in_list.pl
    ├── sum_two_num.pl
    ├── sum_of_list.pl
    ├── multiplication.pl
    └── even-odd-length.pl
```

## 🧪 Sample Queries

### Tower of Hanoi
```prolog
?- tower_of_hanoi(3).
```

### Family Relationships
```prolog
?- father(john, mary).
?- grandparent(john, ann).
```

### List Operations
```prolog
?- conc([1,2], [3,4], R).
R = [1,2,3,4].

?- reverse([a,b,c], R).
R = [c,b,a].
```

### Mathematical Functions
```prolog
?- factorial(5, F).
F = 120.

?- fibonacci(6, F).
F = 8.
```

## 🤝 Contributing

Feel free to fork this repository and contribute by:
1. Adding new Prolog implementations
2. Improving existing algorithms
3. Adding more example use cases
4. Fixing bugs or optimizing code

## 📄 License

This project is created for educational and learning purposes. Feel free to use and modify the code for your own learning.

## 🌟 Show Your Support

If you find this repository helpful, please give it a star! ⭐

---

**Made with ❤️ using Prolog**