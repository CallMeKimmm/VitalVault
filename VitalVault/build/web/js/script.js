document.addEventListener('DOMContentLoaded', function() {
    // Initialize tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    // Form validation
    var forms = document.querySelectorAll('.needs-validation');
    Array.prototype.slice.call(forms).forEach(function(form) {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });

    // Quantity adjustments for cart/medicine
    document.querySelectorAll('.quantity-adjust').forEach(function(button) {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            var input = this.parentNode.querySelector('.quantity-input');
            var currentVal = parseInt(input.value);
            var max = parseInt(input.getAttribute('max'));
            var min = parseInt(input.getAttribute('min'));
            
            if (this.classList.contains('quantity-up')) {
                if (currentVal < max) {
                    input.value = currentVal + 1;
                }
            } else if (this.classList.contains('quantity-down')) {
                if (currentVal > min) {
                    input.value = currentVal - 1;
                }
            }

            input.dispatchEvent(new Event('change'));
        });
    });

    // Confirm before critical actions
    document.querySelectorAll('.confirm-action').forEach(function(link) {
        link.addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to proceed with this medical record action?')) {
                e.preventDefault();
            }
        });
    });

    // Dynamic product filtering
    var catFilter = document.getElementById('category-filter');
    if (catFilter) {
        catFilter.addEventListener('change', function() {
            var categoryId = this.value;
            window.location.href = 'ViewProductServlet?category=' + categoryId;
        });
    }
});

function addToCart(productId, quantity) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'ViewProductServlet', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function() {
        if (xhr.status === 200) {
            var cartCount = document.getElementById('cart-count');
            if (cartCount) {
                var currentCount = parseInt(cartCount.textContent) || 0;
                cartCount.textContent = currentCount + parseInt(quantity);
            }
            alert('Item successfully added to your medical supply list.');
        } else {
            alert('There was an issue adding the item. Please try again.');
        }
    };
    xhr.send('productId=' + productId + '&quantity=' + quantity);
}

function updateCartTotal() {
    var total = 0;
    document.querySelectorAll('.subtotal').forEach(function(element) {
        total += parseFloat(element.textContent.replace('$', ''));
    });
    document.getElementById('cart-total').textContent = '$' + total.toFixed(2);
}
