module: dylan-user

define library parsesql
  use common-dylan;
  use io;
  use Regular-expressions;
  use system;
end library;

define module parsesql
  use common-dylan;
  use format-out;
  use streams;
  use standard-io;
  use Regular-expressions, rename: {split => regexp-split};
  use file-system;
end module;

