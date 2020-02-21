const saveAsDraft = document.querySelector("#save-draft");

saveAsDraft.addEventListener("click", event => {
  console.log("Element clicked");
  let article_status = document.getElementById("status");
  article_status.value = 'draft';
});


const saveAndPublish = document.querySelector("#save_published");

saveAndPublish.addEventListener("click", event => {
  console.log("Element clicked");
  let article_status = document.getElementById("status");
  article_status.value = 'published';
});
