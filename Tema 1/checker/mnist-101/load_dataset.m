function [X, y] = load_dataset(path)
  fin = load(path);
  X = fin.X;
  y = fin.y;
end
