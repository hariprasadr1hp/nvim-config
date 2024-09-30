<template>
	<div id="app">
		<!-- Data binding with mustache syntax -->
		<h1>{{ title }}</h1>

		<!-- v-bind for dynamic attributes -->
		<img v-bind:src="imageSrc" alt="Example Image" />

		<!-- v-on for event handling -->
		<button v-on:click="incrementCounter">Click me</button>
		<p>Button clicked {{ counter }} times.</p>

		<!-- v-model for two-way data binding -->
		<input v-model="userInput" placeholder="Type something..." />
		<p>You typed: {{ userInput }}</p>

		<!-- Conditional rendering with v-if, v-else-if, v-else -->
		<p v-if="counter === 0">You haven't clicked the button yet.</p>
		<p v-else-if="counter > 0 && counter < 10">You've clicked the button a few times.</p>
		<p v-else>You've clicked the button many times!</p>

		<!-- v-for for rendering lists -->
		<ul>
			<li v-for="(item, index) in items" :key="index">{{ index + 1 }}. {{ item }}</li>
		</ul>

		<!-- v-show for conditional display -->
		<p v-show="showMessage">This message is conditionally displayed using v-show.</p>

		<!-- Component interaction with props -->
		<child-component :message="childMessage"></child-component>
	</div>
</template>

<script>
// Importing a child component
import ChildComponent from './ChildComponent.vue';

export default {
	name: 'App',
	components: {
		ChildComponent,
	},
	data() {
		return {
			title: 'Hello Vue.js!',
			imageSrc: 'https://via.placeholder.com/150',
			counter: 0,
			userInput: '',
			items: ['Item 1', 'Item 2', 'Item 3'],
			showMessage: true,
			childMessage: 'Hello from the parent component!'
		};
	},
	methods: {
		incrementCounter() {
			this.counter++;
		},
	},
	watch: {
		// Watcher for userInput changes
		userInput(newVal, oldVal) {
			console.log('User input changed from', oldVal, 'to', newVal);
		}
	},
	computed: {
		// Computed property example
		reversedInput() {
			return this.userInput.split('').reverse().join('');
		}
	},
	mounted() {
		console.log('App component mounted');
	}
};
</script>

<style scoped>
/* Scoped CSS for this component */
#app {
	font-family: 'Avenir', Helvetica, Arial, sans-serif;
	text-align: center;
	margin-top: 60px;
}

button {
	background-color: #42b983;
	color: white;
	padding: 10px 20px;
	border: none;
	cursor: pointer;
}

button:hover {
	background-color: #333;
}
</style>
