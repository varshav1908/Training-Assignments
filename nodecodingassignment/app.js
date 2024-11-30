const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
const port = 3000;

// Middleware to parse form data
app.use(bodyParser.urlencoded({ extended: true }));

// Set the views directory and set Pug as the template engine
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

// Sample users for login verification
const users = [
  { username: 'admin', password: 'admin123' },
  { username: 'user', password: 'user123' },
];

// Sample product array to store products
let products = [];

// Route to render main form
app.get('/', (req, res) => {
  res.render('landingpage'); // Renders 'landingpage.pug'
});

// Route to render login form for User login
app.get('/user-login', (req, res) => {
  res.render('login', { type: 'user' }); // Pass type as 'user' to indicate this is for user login
});

// Route to handle login form submission
app.post('/login', (req, res) => {
  const { username, password } = req.body;

  // Check if the entered username and password match any user
  const user = users.find(u => u.username === username && u.password === password);

  if (user) {
    res.render('search', { username: user.username });
  } else {
    res.render('login', { error: 'Invalid username or password' });
  }
});

// Route to render the Admin Dashboard
app.get('/adminDAshboard', (req, res) => {
  res.render('adminDAshboard', { products: products }); // Pass the products array to the view
});

// Route to handle product registration
app.post('/adminDAshboard', (req, res) => {
  const { productname, productid, price, category, mfgdate, expdate } = req.body;

  // Validation logic (you can add more validation if needed)
  if (!productname || !productid || !price || !category || !mfgdate || !expdate) {
    return res.render('adminDAshboard', { error: 'All fields are required', products: products });
  }

  // Add the new product to the products array
  const newProduct = { name: productname, productId: productid, price, category, mfgdate, expdate };
  products.push(newProduct);

  // Render the updated product list
  res.render('adminDAshboard', { products: products });
});





// Sample product array (this could come from a database in a real application)
let products1 = [
  { name: 'Product 1', productId: '1', price: 100, category: 'Electronics' },
  { name: 'Product 2', productId: '2', price: 200, category: 'Furniture' },
  { name: 'Product 3', productId: '3', price: 300, category: 'Clothing' },
  // Add more products here
];

// Route to render search form
app.get('/search', (req, res) => {
  res.render('search'); // Render the search.pug page
});

// Route to handle search form submission
app.post('/search', (req, res) => {
  const { searchbyname, searchbycategory } = req.body;

  if (!searchbyname && !searchbycategory) {
    return res.render('search', { error: 'Please enter a search criteria.' });
  }

  // Filter products based on the search criteria
  const filteredProducts = products.filter(product => {
    const nameMatch = searchbyname ? product.name.toLowerCase().includes(searchbyname.toLowerCase()) : true;
    const categoryMatch = searchbycategory ? product.category.toLowerCase().includes(searchbycategory.toLowerCase()) : true;
    return nameMatch && categoryMatch;
  });

  // Render the search page with the filtered products
  res.render('search', { searchResults: filteredProducts });
});






// Start the server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});




