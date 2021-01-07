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
      const tags = xhr.response.tags;
      const tagSearchResultWrapper = document.querySelector("#tag-search-result");
      tagSearchResultWrapper.innerHTML = "";
      tagSearchResultWrapper.setAttribute("style", "");
      if (tags.length != 0) {
        tagSearchResultWrapper.setAttribute("style", "border: 1px solid black");
      }
      tags.forEach(function (tag) {
        const tagElement = document.createElement("div");
        tagElement.innerText = tag.name;
        console.log("検索結果要素:", tagElement);
        tagSearchResultWrapper.appendChild(tagElement);
        tagElement.addEventListener("click", ()=> {
          tagNameInput.value = tagElement.textContent;
          tagSearchResultWrapper.setAttribute("style", "");
          tagSearchResultWrapper.innerHTML= "";
        });
      })
    }
  })
})

// addEventListener("EventName", (InputEvent name) => { method })
// InputEvent means making InputEvent object 
// target gets the attribute which is in the element pointed at getElementById

