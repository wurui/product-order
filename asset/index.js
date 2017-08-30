define(['oxjs'], function (OXJS) {
    var getAddress = function ($div) {
            var obj = {};
            var addressfields = 'name,phone,province,city,district,street,detail'.split(',');
            for (var i = 0; i < addressfields.length; i++) {
                var field = addressfields[i];
                obj[field] = $('.J_address_' + field, $div).html();
            }
            return obj;
        },
        dataAdapter = function (data) {

            var result = {
                title: data.title,
                totalcount: data.amount,
                totalfee: data.total,
                delivery: JSON.stringify(data.address)
            };
            return result;

        };
    return {
        init: function ($mod) {
            /**
             * 'title',totalcount,totalfee,delivery,pack,bill
             * */
            var uid = $mod.attr('data-uid'),
                dsid = $mod.attr('data-dsid'),
                Rest = OXJS.useREST('order/' + dsid + '/u/' + encodeURIComponent(uid)).setDevHost('http://local.openxsl.com/');;

            var triggerTd;

            var payurl = $mod.attr('data-payurl');

            var f = $('form', $mod)[0];

            var $count = $('.J_count', $mod),
                $totalPrice = $('.J_total', $mod),
                price = $.trim($('.J_price').text()) - 0,
                $amountInput = $('.J_input', $mod).on('change', onAmountChange);

            var onAmountChange = function () {
                var amount = $amountInput.val();
                $count.html(amount);
                var total = amount * price
                $totalPrice.html(total);
                f.total.value = total;
            };


            var $popup = $('.J_popup', $mod).on('tap', function () {
                $popup.removeClass('popup-show')
            }).on('change', function (e) {
                //console.log('addr changed!', e.target,triggerTd);
                var $li = $(e.target).closest('li'),
                    name = $('.J_addr_name', $li).html(),
                    detail = $('.J_addr_detail', $li).html();
                $('.J_addr_name', triggerTd).html(name);
                $('.J_addr_detail', triggerTd).html(detail);
            });
            var tap_ts = 0;
            $mod.on('tap', function (e) {
                var tar = e.target,
                    action = tar.getAttribute('data-action');

                if (Date.now() - tap_ts < 100) {
                    return false
                }
                tap_ts = Date.now();
                //triggerTd=null;
                switch (action) {
                    case 'popup':
                        $popup.addClass('popup-show');
                        triggerTd = $(tar).closest('td');
                        break
                    case 'plus':
                        var $input = $(tar).prev('.J_input');
                        $input.val($input.val() - -1);
                        onAmountChange();
                        break
                    case 'minus':

                        var $input = $(tar).next('.J_input');
                        $input.val(Math.max(1, $input.val() - 1));
                        onAmountChange();
                        break
                    case 'submit':
                        var param = OXJS.formToJSON(f),
                            addr_name = $('.J_addr_name', f).html(),
                            addr_detail = $('.J_addr_detail', f).html();
                        param.address = getAddress(f);

                        //param.address = addr_name.replace(/\s+/g, '') + ' ' + addr_detail.replace(/\s+/g, '');
                        //console.log('param', param);
                        //console.log('data',dataAdapter(param))
                        Rest.post(dataAdapter(param),function(r){
                            //console.log('order submit ok',r)
                            if(r&&r.code==0){
                                location.href = payurl + (payurl.indexOf('?') > -1 ? '&' : '?') + 'oid=' + r.message
                            }else{
                                OXJS.toast(r&& r.message||'FAIL')
                            }

                        })
                        /*
                         OXJS.dbtool({
                         dsname: 'orders',
                         method: 'insert',
                         data: param
                         }, function (r) {
                         if (r.data && r.data.tradeno) {
                         location.href = payurl + (payurl.indexOf('?') > -1 ? '&' : '?') + 'tradeno=' + r.data.tradeno
                         } else {
                         alert(r.error)
                         }
                         });*/
                        break;
                }
            });
        }
    }
})
