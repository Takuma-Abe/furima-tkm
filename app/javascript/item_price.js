window.addEventListener("DOMContentLoaded", () => {
  const path = location.pathname 
  // location.pathname の戻り値：現ページURLのパス名
  const pathRegex = /^(?=.item)(?=.*edit)/

  if (path === "/items/new" || path === "/items" || pathRegex.test(path)){
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

    priceInput.addEventListener("input", ()=> {
      const inputValue = document.getElementById("item-price").value;
      addTaxDom.innerHTML = Math.floor(inputValue * 0.1).toLocaleString();
      profitDom.innerHTML = Math.floor(inputValue * 0.9).toLocaleString();
    })
  }
})