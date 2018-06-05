using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using KeysOnboardingV2.Models;
using System.Data.Entity.Infrastructure;
using System.ComponentModel.DataAnnotations;

namespace KeysOnboardingV2.Controllers
{

    public class ProductSoldViewModel
    {

        public int Id { get; set; }
        [Display(Name="Product")]
        public long ProductId { get; set; }
        [Display(Name = "Customer")]
        public long CustomerId { get; set; }
        [Display(Name = "Store")]
        public int StoreId { get; set; }
        [Display(Name = "Date of Purchase")]
        public string DateSold { get; set; }
    }

    public class ProductSoldController : Controller
    {
        private KeysOnboardingV2Entities db = new KeysOnboardingV2Entities();

        // GET: Customers
        public ActionResult Index()
        {
            var psold = new ProductSold();
            ViewBag.CustomerId = new SelectList(db.Customers, "Id", "CustomerName", psold.CustomerId);
            ViewBag.ProductId = new SelectList(db.Products, "Id", "ProductName", psold.ProductId);
            ViewBag.StoreId = new SelectList(db.Stores, "Id", "StoreName", psold.StoreId);
            return View();
        }


        public JsonResult List()
        {
            var productsold = db.ProductSolds.Include(s => s.Customer).Include(s => s.Product).Include(s => s.Store).Select(x => new
            {
                Id = x.Id,
                ProductId = x.Product.ProductName,
                CustomerId = x.Customer.CustomerName,
                StoreId = x.Store.StoreName,
                DateSold = x.DateSold.Day + "- " + x.DateSold.Month + "-" + x.DateSold.Year
             }).ToList();

            return Json(productsold, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Add(ProductSold psold)
        {
            db.ProductSolds.Add(psold);
            db.SaveChanges();
            
            return Json(db.SaveChanges(), JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetbyID(int ID)
       {
            var ProductSold = db.ProductSolds.Where(x => x.Id == ID).Select(x => new ProductSoldViewModel
            {
                Id = ID,
                CustomerId = x.CustomerId,
                DateSold = x.DateSold.Day + "- " + x.DateSold.Month + "-" + x.DateSold.Year,
                StoreId = x.StoreId,
                ProductId = x.ProductId
            }).FirstOrDefault();
            return Json(ProductSold, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Update(ProductSold psold)
        {
            try
            {
                db.Entry(psold).State = EntityState.Modified;
                return Json(db.SaveChanges(), JsonRequestBehavior.AllowGet);
            }
            catch (DbUpdateConcurrencyException ex)
            {
                ex.Entries.Single().Reload();
                return Json(db.SaveChanges(), JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult RemoveProduct(long ID)
        {
            ProductSold psold = db.ProductSolds.Find(ID);
            db.ProductSolds.Remove(psold);
            return Json(db.SaveChanges(), JsonRequestBehavior.AllowGet);
        }


        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
