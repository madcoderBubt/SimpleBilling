import { Component, OnInit, Inject, Output, EventEmitter } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Customer, Inventory, InventoryProduct, Product } from '../model/BillingModels';
import { FormArray, FormBuilder, FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-billing-details',
  templateUrl: './billing-details.component.html',
  styleUrls: ['./billing-details.component.css']
})
export class BillingDetailsComponent implements OnInit {
  @Output('ngModelChange') update = new EventEmitter();

  inventory: Inventory | undefined;
  products: Product[] =[];
  customers: Customer[] = [];
  billNo = 'inv-002';
  inventoryForm: FormGroup;
  needToBeAddedProductId: number = -1;

  constructor(private fb: FormBuilder,
    private http: HttpClient,
    @Inject('BASE_URL') private baseUrl: string) {
    this.getProduct();
    this.getCustomer();

    this.inventoryForm = new FormGroup({
      id: new FormControl(''),
      date: new FormControl(''),
      billNo: new FormControl(''),
      customerId: new FormControl('-1'),
      totalDiscount: new FormControl(''),
      totalBillAmount: new FormControl(''),
      dueAmount: new FormControl(''),
      paidAmount: new FormControl(''),
      products: this.fb.array([
        //this.generateInventoryProductForm()
      ])
    });
  }

  ngOnInit(): void {
    
  }

  findByBillNo() {
    //billNo: string
    //debugger;
    this.http.get<Inventory>(this.baseUrl + 'Billing/inventory/' + this.billNo).subscribe(result => {
      this.inventory = result;
      this.inventory.products.forEach(p => {
        let x = this.products?.find(f => f.id == p.productId);
        p.product = x as Product;
      })

      console.log(this.inventory);
      this.generateInventoryForm();
    }, error => console.error(error));
  }
  saveInventoryData() {
    if (this.inventoryForm.valid) {
      this.http.post<Inventory>(this.baseUrl + 'Billing/inventory', this.inventoryForm.getRawValue()).subscribe(result => {
        this.findByBillNo();
      }, error => console.error(error));
    } else console.log("Form Data is invalid!")
  }
  onChangeCalc() {
    //debugger;
    let totalNet: number = 0;
    let totalDiscount: number = 0;
    let totalDue: number = 0;
    for (let item of this.getItems().controls) {
      let data: InventoryProduct = item.getRawValue() as InventoryProduct;
      console.log(data);

      totalNet += data.rate * data.qty;
      totalDiscount += data.discount;
    }
    totalNet = totalNet - totalDiscount;
    totalDue = totalNet - this.inventoryForm.get("paidAmount")?.value;

    this.inventoryForm.get("totalBillAmount")?.setValue(totalNet.toFixed(2));
    this.inventoryForm.get("totalDiscount")?.setValue(totalDiscount.toFixed(2));
    this.inventoryForm.get("dueAmount")?.setValue(totalDue.toFixed(2));
  }
  addNewProduct() {
    //debugger;
    if (!this.inventory || (this.inventory && this.inventory.id < 0)) return;
    let datas: InventoryProduct[] = this.getItems().getRawValue() as InventoryProduct[];

    this.needToBeAddedProductId = Number((document.getElementById("needToBeAddedProductId") as HTMLSelectElement).value);
    let itemFound = datas.findIndex(f => f.productId == this.needToBeAddedProductId);
    if (itemFound >= 0) return;

    let item = this.generateInventoryProductForm();
    let temp: any = {
        id: -1,
        inventoryId: this.inventory?.id ?? 0,
        productId: this.needToBeAddedProductId,
        discount: 0,
        qty: 1,
        rate: this.products.find(f => f.id == this.needToBeAddedProductId)?.rate ?? 0
    }
    item.patchValue(temp);
    (this.inventoryForm.get('products') as FormArray).push(item);

    this.onChangeCalc();
  }
  getProduct() {
    this.http.get<Product[]>(this.baseUrl + 'Billing/Products').subscribe(result => {
      this.products = result;
      console.log(this.products)
    }, error => console.error(error));
  }
  getCustomer() {
    this.http.get<Customer[]>(this.baseUrl + 'Billing/customers').subscribe(result => {
      this.customers = result;
      console.log(this.customers);
    }, error => console.error(error));
  }

  generateInventoryForm() {
    if (this.inventory) {
      this.inventoryForm.setControl("products", this.loadProducts());
      this.inventoryForm.patchValue(this.inventory);
      console.log(this.inventoryForm);
    }      
  }
  loadProducts(): FormArray {
    let formArr = new FormArray<FormGroup>([]);
    this.inventory?.products.forEach(s => {
      formArr.push(this.generateInventoryProductForm() as FormGroup);
    });
    return formArr;
  }
  generateInventoryProductForm() {
    return new FormGroup({
      id: new FormControl(''),
      inventoryId: new FormControl(''),
      productId: new FormControl(''),
      rate: new FormControl(''),
      discount: new FormControl(''),
      qty: new FormControl(''),
    });
  }
  getItems() {
    return this.inventoryForm.get("products") as FormArray;
  }
  getProductName(id: number) {
    return this.products.find(f => f.id == id)?.name;
  }
}

