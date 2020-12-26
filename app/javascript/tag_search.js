window.addEventListener("DOMContentLoaded", ()=> {
  const tagNameInput = document.getElementById("tag-name-form")
  if (!tagNameInput) return null;

  tagNameInput.addEventListener("input", (e)=> {
    const input = e.target.value;
    const xhr = new XMLHttpRequest();
    xhr.open("GET", `/tags/?tag_name=${input}`, true);
    xhr.responseType = "json";
    xhr.send();
    xhr.onload = () => {
      console.log("tag_result:", xhr.response.tags);
    }
  })
})

// addEventListener("EventName", (InputEvent name) => { method })
// InputEvent means making InputEvent object 
// target gets the attribute which is in the element pointed at getElementById

