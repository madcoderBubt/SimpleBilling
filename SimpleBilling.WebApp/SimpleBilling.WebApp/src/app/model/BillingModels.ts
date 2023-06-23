
interface Inventory {
  id: number;
  date: Date;
  billNo: string;
  customerId: number;
  totalDiscount: number;
  totalBillAmount: number;
  dueAmount: number;
  paidAmount: number;

  products: InventoryProduct[];
  customer: Customer;
}
interface InventoryProduct {
  id: number;
  inventoryId: number;
  productId: number;
  rate: number;
  discount: number;
  qty: number;
  product: Product;
}
interface Product {
  id: number;
  code: string;
  name: string;
  rate: number;
}
interface Customer {
  id: number;
  name: string;
  address: string;
  phone: string;
}

export { Customer, Product, Inventory, InventoryProduct }
