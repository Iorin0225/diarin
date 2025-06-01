document.addEventListener("turbo:load", function () {
  document.querySelectorAll('.article--novel .article__content').forEach(function (articleObj) {
    articleObj.scrollTo({
      top: 0,
      left: -1,
      behavior: 'smooth'
    });
  });
});
