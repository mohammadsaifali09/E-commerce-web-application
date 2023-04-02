function addToCart(pid, pname, price)
{
    let cart = localStorage.getItem("cart");
    if (cart == null)
    {
        //No cart yet
        let products = [];
        let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
//        console.log("product is added for first time");
        showToast("Item is added to cart")
    }
    else
    {
        //Cart is already present
        let pcart = JSON.parse(cart);
        let oldProduct = pcart.find((item) => item.productId == pid);
        if (oldProduct)
        {
            //We have to increase the quantity
            oldProduct.productQuantity=oldProduct.productQuantity+1;
            pcart.map((item)=>{
                if(item.productId==oldProduct.productId)
                {
                    item.productQuantity=oldProduct.productQuantity;
                }
            })
            localStorage.setItem("cart",JSON.stringify(pcart));
//            console.log("Product quantity is increased");
            showToast(oldProduct.productName+" quantity is increased , Quantity = "+oldProduct.productQuantity)
        }
        else
        {
            //We have add the product
            let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
            pcart.push(product);
            localStorage.setItem("cart",JSON.stringify(pcart));
//            console.log("product is added");
            showToast("Product is added to cart")
        }
    }
    updateCart();
}

//Update cart
function updateCart()
{
    let cartString=localStorage.getItem("cart");
    let cart=JSON.parse(cartString);
    if (cart==null || cart.length==0)
    {
        console.log("Cart is empty");
        $(".cart-items").html("(0)");
        $(".cart-body").html("<h5>Your E-commerce Cart is empty.</h5>");
        $(".checkout-btn").attr('disabled',true);
    }
    else
    {
        //There is some in cart to show
        console.log(cart);
        $(".cart-items").html(`(${cart.length})`);
        let table=`
            <table class='table'>
            <thead class='thead-light'>
                <tr>
                    <th>Item name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                    <th>Action</th>
                </tr>
            </thead>
        `;
        
        let totalPrice=0;
        cart.map((item)=>{
            table +=`
                <tr>
                    <td>${item.productName}</td>
                    <td>${item.productPrice}</td>
                    <td>${item.productQuantity}</td>
                    <td>${item.productQuantity*item.productPrice}</td>
                    <td> <button onclick='deleteItemFromCart(${item.productId})' class='btn btn-danger btn-sm'>Delete</button> </td>
                </tr>
            `
            
            totalPrice+=item.productPrice*item.productQuantity;
            
        })
        
        table=table+`
            <tr>
                <td colspan='5' class='text-right font-weight-bold m-5'>Cart subtotal: ${totalPrice}</td>
            </tr>
        </table>`
        $(".cart-body").html(table);
        $(".checkout-btn").attr('disabled',false);
    }
}

//Delete item
function deleteItemFromCart(pid)
{
    let cart=JSON.parse(localStorage.getItem('cart'));
    let newcart=cart.filter((item)=>item.productId !=pid)
    
    localStorage.setItem('cart',JSON.stringify(newcart))
    
    updateCart();
    
    showToast("Item is delete from cart")
}

$(document).ready(function (){
    updateCart();
})

function  showToast(content)
{
    $("#toast").addClass("display");
    $("#toast").html(content);
    setTimeout(()=>{
        $("#toast").removeClass("display");
    },2000);
}

function goToCheckout()
{
    window.location="checkout.jsp"
}