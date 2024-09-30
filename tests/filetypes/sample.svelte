<script>
	// Reactive variables
	let name = "John Doe";
	let count = 0;
	let userInput = "";
	let items = ["Item 1", "Item 2", "Item 3"];
	let showMessage = true;

	// Reactive statements
	$: reversedInput = userInput.split("").reverse().join("");

	// Functions
	function increment() {
		count += 1;
	}

	function handleInput(event) {
		userInput = event.target.value;
	}

	// Reactive values (store)
	import { writable } from "svelte/store";
	const theme = writable("light");

	// Importing a component
	import ChildComponent from "./ChildComponent.svelte";
</script>

<!-- Main component -->
<div class={$theme === "dark" ? "dark-theme" : "light-theme"}>
	<!-- Data binding with mustache syntax -->
	<h1>Hello {name}!</h1>

	<!-- Event handling -->
	<button on:click={increment}
		>Clicked {count} {count === 1 ? "time" : "times"}</button
	>

	<!-- Two-way data binding with bind: -->
	<input bind:value={userInput} placeholder="Type something..." />
	<p>You typed: {userInput}</p>
	<p>Reversed: {reversedInput}</p>

	<!-- Conditional rendering -->
	{#if count === 0}
		<p>You haven't clicked the button yet.</p>
	{:else if count < 5}
		<p>You've clicked a few times.</p>
	{:else}
		<p>You've clicked many times!</p>
	{/if}

	<!-- Looping over an array -->
	<ul>
		{#each items as item, index}
			<li>{index + 1}: {item}</li>
		{/each}
	</ul>

	<!-- Conditional display with {#if} and {#else} -->
	{#if showMessage}
		<p>This message is conditionally displayed.</p>
	{/if}

	<!-- Passing props to a child component -->
	<ChildComponent message="Hello from the parent component!" />

	<!-- Toggle theme -->
	<button
		on:click={() => theme.update((t) => (t === "light" ? "dark" : "light"))}
	>
		Toggle Theme
	</button>
</div>

<style>
	/* Scoped styles */
	h1 {
		color: #42b983;
	}

	button {
		background-color: #333;
		color: white;
		padding: 10px 20px;
		border: none;
		cursor: pointer;
	}

	button:hover {
		background-color: #555;
	}

	.light-theme {
		background-color: white;
		color: black;
	}

	.dark-theme {
		background-color: black;
		color: white;
	}
</style>
