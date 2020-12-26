window.addEventListener("DOMContentLoaded", ()=> {
  const tagNameInput = document.getElementById("tag-name-form")
  if (!tagNameInput) return null;

  tagNameInput.addEventListener("input", (e)=> {
    const input = e.target.;
    console.log("Contents:", input)
  })
})

// addEventListener("EventName", (InputEvent name) => { method })
// InputEvent means making InputEvent object 
// target gets the attribute which is in the element pointed at getElementById

