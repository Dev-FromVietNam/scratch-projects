let count = 0;

document.getElementById("greet").addEventListener("click", function () {
  const name = document.getElementById("name").value.trim() || "bạn";
  count += 1;
  document.getElementById("message").textContent = "Chào " + name + ", chúc một ngày vui vẻ!";
  document.getElementById("count").textContent = count;
});
