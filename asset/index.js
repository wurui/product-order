define([],function(){
  return {
    init:function($mod){
        var triggerTd;
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
                    break
                case 'minus':

                    var $input=$(tar).next('.J_input');
                    $input.val(Math.max(1,$input.val()  -1));
                    break
            }
        })
    }
  }
})
