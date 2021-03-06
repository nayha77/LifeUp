package salesman.common.support;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import salesman.common.define.Values;
import salesman.model.User;

public class UserMethodArgumentResolver implements HandlerMethodArgumentResolver {
	
    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        return User.class.isAssignableFrom(parameter.getParameterType());
    }

    @Override
    public Object resolveArgument(MethodParameter parameter
                                , ModelAndViewContainer mavContainer
                                , NativeWebRequest webRequest
                                , WebDataBinderFactory binderFactory) throws Exception {

        HttpSession session =  webRequest.getNativeRequest(HttpServletRequest.class).getSession();
        Object user = session.getAttribute(Values._SESSION_USER_);
        return user != null ? user : User.anonymous();
    }
}
