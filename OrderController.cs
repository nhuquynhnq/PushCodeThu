using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MultiShop.Controllers
{
    public class OrderController : Controller
    {
        MultiShopDbContext db = new MultiShopDbContext();
        //
        // GET: /Order/
        public ActionResult Checkout()
        {
            var model = new Order();
            model.CustomerId = User.Identity.Name;
            model.OrderDate = DateTime.Now;
            model.Amount = ShoppingCart.Cart.Total;
            
            return View(model);
        }

        [HttpPost]
        public ActionResult Purchase(Order model)
        {
        
            var cart = ShoppingCart.Cart;
            foreach (var p in cart.Items)
            {
                var d = new OrderDetail
                {
                    Order = model,
                    ProductId = p.Id,
                    UnitPrice = p.UnitPrice,
                    Discount = p.Discount,
                    Quantity = p.Quantity,
                   

                };

                db.OrderDetails.Add(d);
            }
            db.SaveChanges(); //Ý ơi cái khúc này bị lỗi có gì p kêu p nhi fix sau tạm thời thanh toán trên paypal
            
            // Thanh toán trực tuyến
            //var api = new WebApiClient<AccountInfo>();
            //var data = new AccountInfo { 
            //    Id=Request["BankAccount"],
            //    Balance = cart.Total
            //};
            //api.Put("api/Bank/nn", data);
            return RedirectToAction("PaymentWithPayPal","Payment",model);
        }

        public ActionResult Detail(int id)
        {
            var order = db.Orders.Find(id);
            return View(order);
        }

        public ActionResult List()
        {
            var orders = db.Orders
                .Where(o => o.CustomerId == User.Identity.Name);
            return View(orders);
        }
	}
}