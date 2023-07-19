let id: number = 0;

const assign = (value: number) => {
  id = value;
  console.log(`Set id=${id}`);
};

const newID = (): number => {
  id++;
  console.log(`newID=${id}`);
  return id;
};

export const idHolder = {
  assign,
  newID,
};
