document.addEventListener("DOMContentLoaded", function() {
   
    const regform = document.getElementById("regform");
    const loginForm = document.getElementById("loginForm");
    const loginFormDiv = document.getElementById("login-form");
    const formDiv = document.getElementById("form");
    const booksDisplay = document.getElementById("books-display");
    const booksList = document.getElementById("books-list");


    document.getElementById("show-login").addEventListener("click", function() {
        formDiv.style.display = "none";
        loginFormDiv.style.display = "block";
    });


    document.getElementById("show-register").addEventListener("click", function() {
        loginFormDiv.style.display = "none";
        formDiv.style.display = "block";
    });

    
    regform.addEventListener("submit", function(event) {
        event.preventDefault();
        
        let name = document.getElementById("name").value;
        let age = document.getElementById("age").value;
        let email = document.getElementById("email").value;
        let categories = Array.from(document.getElementById("categories").selectedOptions).map(option => option.value);

        if (age < 10 || age > 80) {
            alert("Age must be between 10 and 80.");
            return;
        }

        
        localStorage.setItem("user", JSON.stringify({ name, age, email, categories }));

        
        formDiv.style.display = "none";
        loginFormDiv.style.display = "block";
    });

    
    loginForm.addEventListener("submit", function(event) {
        event.preventDefault();
        let loginEmail = document.getElementById("loginEmail").value;
        let user = JSON.parse(localStorage.getItem("user"));

        if (user && user.email === loginEmail) {
            
            loginFormDiv.style.display = "none";
            booksDisplay.style.display = "block";

           
            displayBooks(user.categories);
        } else {
            alert("Email not registered or incorrect.");
        }
    });

 
    function displayBooks(categories) {
        const books = {
            fiction: ["The Great Gatsby", "1984", "To Kill a Mockingbird"],
            "non-fiction": ["Sapiens", "Educated", "Becoming"],
            science: ["A Brief History of Time", "Cosmos", "The Selfish Gene"],
            technology: ["The Innovators", "Steve Jobs", "The Second Machine Age"],
            magazines: ["National Geographic", "TIME", "The Economist"],
            "kids-education": ["The Very Hungry Caterpillar", "Where the Wild Things Are", "Matilda"]
        };

        let booksToDisplay = [];

        categories.forEach(category => {
            booksToDisplay = [...booksToDisplay, ...books[category]];
        });

        if (booksToDisplay.length === 0) {
            booksList.innerHTML = "<p>No books available in your selected categories.</p>";
        } else {
            let bookItems = booksToDisplay.map(book => 
                `<div class="col-md-4"><div class="card"><div class="card-body"><p>${book}</p></div></div></div>`
            ).join('');
            booksList.innerHTML = bookItems;
        }
    }
});
