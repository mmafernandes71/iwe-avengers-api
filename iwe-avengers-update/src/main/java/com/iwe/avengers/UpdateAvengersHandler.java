package com.iwe.avengers;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.lambda.response.HandlerResponse;
import com.iwe.avengers.dao.AvengerDAO;
import com.iwe.avengers.exception.AvengerNotFoundException;

public class UpdateAvengersHandler implements RequestHandler<Avenger, HandlerResponse> {
	private AvengerDAO dao = new AvengerDAO();
	
	

	@Override
	public HandlerResponse handleRequest(final Avenger avenger, final Context context) {
		Avenger updateAvenger = null;
		
		context.getLogger().log("  [#] - Searching avenger by id ");
		
		if (dao.search(avenger.getId()) != null) {
			
			
			context.getLogger().log(" [#] -  AvengerFound, updating ");
			
			updateAvenger = dao.create(avenger);
	          
	          context.getLogger().log(" [#] - Sucesso Update : ");
		} else {
			throw new AvengerNotFoundException("[NotFound] - Avenger id: "
                    + avenger.getId());
		}
		
		
		final HandlerResponse response = HandlerResponse.builder().setObjectBody(avenger).build();
			
		return response;
	}
}
