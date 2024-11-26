// Bakery Item Constructor
function BakeryItem(name, price, weight) {
    this.name = name;
    this.price = price;
    this.weight = weight;
}

// Sample data
const items = [
    new BakeryItem('Chocolate Cake', 20.00, '1kg'),
    new BakeryItem('Croissant', 2.50, '100g'),
    new BakeryItem('Fruit Tart', 15.00, '500g'),
    new BakeryItem('Eclair', 3.00, '150g'),
];

// Cart Object
const cart = {
    items: [],
    addItem: function(item) {
        this.items.push(item);
        this.updateCartCount();
    },
    updateCartCount: function() {
        document.getElementById('cart-count').innerText = this.items.length;
    },
    getTotalPrice: function() {
        return this.items.reduce((total, item) => total + item.price, 0).toFixed(2);
    },
    displayCart: function() {
        const cartItemsList = document.getElementById('cart-items');
        cartItemsList.innerHTML = ''; // Clear previous items
        this.items.forEach(item => {
            const listItem = document.createElement('li');
            listItem.textContent = `${item.name} - $${item.price.toFixed(2)}`;
            cartItemsList.appendChild(listItem);
        });
        document.getElementById('total-price').textContent = `Total: $${this.getTotalPrice()}`;
    }
};

// Function to display products
function displayProducts() {
    const productList = document.getElementById('product-list');
    items.forEach(item => {
        const productDiv = document.createElement('div');
        productDiv.classList.add('product');
        productDiv.innerHTML = `
            <h3>${item.name}</h3>
            <p>Price: $${item.price.toFixed(2)}</p>
            <p>Weight: ${item.weight}</p>
            <button onclick="addToCart('${item.name}')">Add to Cart</button>
        `;
        productList.appendChild(productDiv);
    });
}

// Function to add item to cart
function addToCart(itemName) {
    const item = items.find(i => i.name === itemName);
    if (item) {
        cart.addItem(item);
        alert(`${item.name} has been added to your cart!`);
    }
}

// Function to view cart
function viewCart() {
    cart.displayCart();
    document.getElementById('cart-modal').style.display = "block";
}

// Function to close the cart modal
function closeCart() {
    document.getElementById('cart-modal').style.display = "none";
}

// Initialize the application
displayProducts();