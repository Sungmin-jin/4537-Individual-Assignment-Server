const escape = function (str) {
  let newStr = str.replace(/'/g, "\\'");
  newStr = newStr.replace(/"/g, '\\"');
  return newStr;
};

module.exports = escape;
