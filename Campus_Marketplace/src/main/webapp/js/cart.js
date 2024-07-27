document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".remove-item").forEach(function (button) {
        button.addEventListener("click", function () {
            var productId = button.dataset.productId;

            // Send AJAX request to remove item
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "cart", true); // Corrected URL here
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onload = function () {
                if (xhr.status === 200) {
                    console.log(xhr.responseText);
                    // Reload the page after successful removal
                    location.reload();
                } else {
                    console.error(xhr.statusText);
                }
            };
            xhr.onerror = function () {
                console.error("Request failed");
            };

            // Convert FormData to URL-encoded format
            var urlEncodedData = "productId=" + encodeURIComponent(productId);
            xhr.send(urlEncodedData);
        });
    });
});
