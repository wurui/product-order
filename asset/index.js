define(['oxjs'],function(OXJS){
  return {
    init:function($mod){
        var triggerTd;

        var f=$('form',$mod)[0];

        var $count=$('.J_count',$mod),
            $totalPrice=$('.J_total',$mod),
            price= $.trim($('.J_price').text())- 0,
            $amountInput=$('.J_input',$mod).on('change',onAmountChange);

        var onAmountChange=function(){
            var amount=$amountInput.val();
            $count.html(amount);
            $totalPrice.html(amount * price);
        };



        var $popup=$('.J_popup',$mod).on('tap',function(){
            $popup.removeClass('popup-show')
        }).on('change',function(e){
            //console.log('addr changed!', e.target,triggerTd);
            var $li=$(e.target).closest('li'),
                name=$('.J_addr_name',$li).html(),
                detail=$('.J_addr_detail',$li).html();
            $('.J_addr_name',triggerTd).html(name);
            $('.J_addr_detail',triggerTd).html(detail);
        });
        $mod.on('tap',function(e){
            var tar= e.target,
                action=tar.getAttribute('data-action');
            //triggerTd=null;
            switch (action){
                case 'popup':
                    $popup.addClass('popup-show');
                    triggerTd=$(tar).closest('td');
                    break
                case 'plus':
                    var $input=$(tar).prev('.J_input');
                    $input.val($input.val() - -1);
                    onAmountChange();
                    break
                case 'minus':

                    var $input=$(tar).next('.J_input');
                    $input.val(Math.max(1,$input.val()  -1));
                    onAmountChange();
                    break
                case 'submit':
                    var param=OXJS.formToJSON(f),
                    addr_name=$('.J_addr_name',f).html(),
                        addr_detail=$('.J_addr_detail',f).html();
                    param.address=addr_name.replace(/\s+/g,'')+' '+addr_detail.replace(/\s+/g,'');
                    console.log('param',param);
                    OXJS.dbtool({
                        dsname:'order',
                        method:'insert',
                        data:param
                    },function(r){
                        console.log(r)
                    });
                    break;
            }
        });
    }
  }
})
