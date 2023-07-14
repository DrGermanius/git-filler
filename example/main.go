package main

import (
	"fmt"
)

func main() {
	fmt.Println("Welcome to GoToDo!")
	fmt.Println("-----------------")

	tasks := make(map[int]string)

	for {
		displayMenu()
		var choice int
		fmt.Scanf("%d", &choice)

		switch choice {
		case 1:
			addTask(tasks)
		case 2:
			listTasks(tasks)
		case 3:
			deleteTask(tasks)
		case 4:
			fmt.Println("Thank you for using GoToDo!")
			return
		default:
			fmt.Println("Invalid choice. Please try again.")
		}
	}
}

func displayMenu() {
	fmt.Println("Menu")
	fmt.Println("----")
	fmt.Println("1. Add task")
	fmt.Println("2. List tasks")
	fmt.Println("3. Delete task")
	fmt.Println("4. Quit")
	fmt.Print("Enter your choice: ")
}

func addTask(tasks map[int]string) {
	var taskID int
	fmt.Print("Enter task ID: ")
	fmt.Scanf("%d", &taskID)

	var taskName string
	fmt.Print("Enter task name: ")
	fmt.Scanf("%s", &taskName)

	tasks[taskID] = taskName
	fmt.Println("Task added successfully!")
}

func listTasks(tasks map[int]string) {
	fmt.Println("Tasks")
	fmt.Println("-----")

	if len(tasks) == 0 {
		fmt.Println("No tasks found.")
		return
	}

	for id, name := range tasks {
		fmt.Printf("%d. %s\n", id, name)
	}
}

func deleteTask(tasks map[int]string) {
	var taskID int
	fmt.Print("Enter task ID to delete: ")
	fmt.Scanf("%d", &taskID)

	_, exists := tasks[taskID]

	if exists {
		delete(tasks, taskID)
		fmt.Println("Task deleted successfully!")
	} else {
		fmt.Println("Task not found.")
	}
}