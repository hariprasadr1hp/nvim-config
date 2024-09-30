import React, { useState, useEffect, ChangeEvent, FC } from 'react';

// Define a type for component props
interface UserProps {
	name: string;
	age: number;
	email: string;
}

// Define the props type for the child component
interface ChildComponentProps {
	message: string;
}

// Child component
const ChildComponent: FC<ChildComponentProps> = ({ message }) => {
	return <p>{message}</p>;
};

const App: FC = () => {
	// State with types
	const [count, setCount] = useState<number>(0);
	const [userInput, setUserInput] = useState<string>('');
	const [users, setUsers] = useState<UserProps[]>([]);
	const [isDarkTheme, setIsDarkTheme] = useState<boolean>(false);

	// Event handler with type
	const handleInputChange = (event: ChangeEvent<HTMLInputElement>) => {
		setUserInput(event.target.value);
	};

	// Effect hook to simulate fetching data
	useEffect(() => {
		// Simulate fetching user data
		const fetchedUsers: UserProps[] = [
			{ name: 'John Doe', age: 30, email: 'john.doe@example.com' },
			{ name: 'Jane Smith', age: 25, email: 'jane.smith@example.com' },
		];
		setUsers(fetchedUsers);
	}, []);

	// Toggle theme
	const toggleTheme = () => {
		setIsDarkTheme(!isDarkTheme);
	};

	return (
		<div className={isDarkTheme ? 'dark-theme' : 'light-theme'}>
			<h1>Welcome to React with TypeScript!</h1>

			{/* Two-way binding with input */}
			<input
				type="text"
				value={userInput}
				onChange={handleInputChange}
				placeholder="Type something..."
			/>
			<p>You typed: {userInput}</p>

			{/* Conditional rendering */}
			{count === 0 ? (
				<p>You haven't clicked the button yet.</p>
			) : count < 5 ? (
				<p>You've clicked a few times.</p>
			) : (
				<p>You've clicked many times!</p>
			)}

			{/* Button with event handler */}
			<button onClick={() => setCount(count + 1)}>Clicked {count} times</button>

			{/* Toggle theme button */}
			<button onClick={toggleTheme}>
				Switch to {isDarkTheme ? 'light' : 'dark'} theme
			</button>

			{/* Looping over an array of users */}
			<ul>
				{users.map((user, index) => (
					<li key={index}>
						{user.name}, Age: {user.age}, Email: {user.email}
					</li>
				))}
			</ul>

			{/* Passing props to a child component */}
			<ChildComponent message="Hello from the parent component!" />

			{/* Dynamic class binding */}
			<div className={isDarkTheme ? 'dark-box' : 'light-box'}>
				This box changes color with the theme.
			</div>
		</div>
	);
};

export default App;

// Basic styles for light and dark themes
<style jsx>
	{`
    .light-theme {
      background-color: white;
      color: black;
    }

    .dark-theme {
      background-color: black;
      color: white;
    }

    .light-box {
      background-color: lightgray;
      padding: 20px;
      margin: 10px;
    }

    .dark-box {
      background-color: darkgray;
      padding: 20px;
      margin: 10px;
    }

    button {
      margin: 10px;
      padding: 10px 20px;
      background-color: #42b983;
      color: white;
      border: none;
      cursor: pointer;
    }

    button:hover {
      background-color: #555;
    }
  `}
</style>

